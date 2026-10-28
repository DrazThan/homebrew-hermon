cask "hermon-app" do
  version "0.5.0"
  sha256 "d02e2d127c840ce2d45aa325bfd0f5d7ffeaa0775f8e739d95303c8fde550a1c"

  url "https://github.com/DrazThan/hermon/releases/download/v#{version}/Hermon.app.zip"
  name "Hermon"
  desc "Live monitor deck for AI agent sessions"
  homepage "https://github.com/DrazThan/hermon"

  depends_on arch: :arm64
  depends_on :macos

  app "Hermon.app"

  uninstall quit: "dev.hermon.app"

  zap trash: "~/Library/Application Support/hermon"
end
