cask "hermon-app" do
  version "0.2.0"
  sha256 "80ed836b757e1e6a6c207a3030ff10c9227cf609ab57e1c63f372e55db668367"

  url "https://github.com/DrazThan/hermon/releases/download/v#{version}/Hermon.app.zip"
  name "Hermon"
  desc "Live monitor deck for Hermes, Claude Code, and OpenCode sessions"
  homepage "https://github.com/DrazThan/hermon"

  depends_on :macos

  app "Hermon.app"

  uninstall quit: "dev.hermon.app"

  zap trash: "~/Library/Application Support/hermon"
end
