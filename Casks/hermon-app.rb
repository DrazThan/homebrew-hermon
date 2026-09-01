cask "hermon-app" do
  version "0.3.0"
  sha256 "b3b3d1e9ef0ea0957e5e65d14d24a9186b541c5dfc8ab34d26afc70274f9e2dc"

  url "https://github.com/DrazThan/hermon/releases/download/v#{version}/Hermon.app.zip"
  name "Hermon"
  desc "Live monitor deck for Hermes, Claude Code, and OpenCode sessions"
  homepage "https://github.com/DrazThan/hermon"

  depends_on :macos

  app "Hermon.app"

  uninstall quit: "dev.hermon.app"

  zap trash: "~/Library/Application Support/hermon"
end
