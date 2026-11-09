defmodule Membrane.RTSPTest do
  use ExUnit.Case

  alias Membrane.RTSP

  describe "Session" do
    test "start fails if uri is not valid" do
      assert {:error, :invalid_url} = RTSP.start("invalid uri")
    end

    test "start fails when server can not be reached" do
      assert {:error, :nxdomain} = RTSP.start("rtsp://non.existent.domain.com:444")
    end
  end

  test "refuses a URL holding a raw control character" do
    for url <- ["rtsp://a\rb:pw@localhost:5554/s", "rtsp://localhost:5554/s\r\nX-Injected: 1"] do
      assert RTSP.start(url) == {:error, :invalid_url}
    end
  end
end
