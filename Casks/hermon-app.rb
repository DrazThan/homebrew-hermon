cask "hermon-app" do
  version "0.1.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/DrazThan/hermon/releases/download/v#{version}/Hermon.app.zip"
  name "Hermon"
  desc "Live monitor deck for Hermes, Claude Code, and OpenCode sessions"
  homepage "https://github.com/DrazThan/hermon"

  depends_on :macos

  app "Hermon.app"

  uninstall quit: "dev.hermon.app"

  zap trash: "~/Library/Application Support/hermon"
end
