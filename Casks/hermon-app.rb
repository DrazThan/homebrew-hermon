cask "hermon-app" do
  version "0.4.1"
  sha256 "ffedb05cf3f5e501c2e68c13cab97702505a354b13254f27655b667d7c67febd"

  url "https://github.com/DrazThan/hermon/releases/download/v#{version}/Hermon.app.zip"
  name "Hermon"
  desc "Live monitor deck for AI agent sessions"
  homepage "https://github.com/DrazThan/hermon"

  depends_on :macos

  app "Hermon.app"

  uninstall quit: "dev.hermon.app"

  zap trash: "~/Library/Application Support/hermon"
end
