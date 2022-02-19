defmodule CssBundler.FsWatcher do
  use GenServer

  require Logger

  def start_link(_args) do
    GenServer.start_link(__MODULE__, [])
  end

  def init(_args) do
    dirs = Application.get_env(:css_bundler, :dirs)
    entrypoint_file = Application.get_env(:css_bundler, :entrypoint_file)
    {:ok, watcher_pid} = FileSystem.start_link(dirs: [entrypoint_file | dirs])
    FileSystem.subscribe(watcher_pid)

    {:ok,
     %{
       watcher_pid: watcher_pid,
       extensions:
         Application.get_env(:css_bundler, :extensions, [".css"]) |> CssBundler.pad_extensions()
     }}
  end

  def handle_info(
        {:file_event, _watcher_pid, {path, events}},
        %{extensions: extensions} = state
      ) do
    with true <- Enum.any?(extensions, &String.ends_with?(path, &1)),
         %File.Stat{type: :regular} <- File.stat!(path),
         true <- Enum.any?(events, &(&1 in [:created, :modified, :renamed])) do
      CssBundler.bundle_css(extensions)
    end

    {:noreply, state}
  end

  def handle_info({:file_event, watcher_pid, :stop}, %{watcher_pid: watcher_pid} = state) do
    {:noreply, state}
  end
end
