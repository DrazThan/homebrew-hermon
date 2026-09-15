class Hermon < Formula
  desc "Live monitor deck for Hermes, Claude Code, Codex, Grok, Gemini CLI, and OpenCode agent sessions"
  homepage "https://github.com/DrazThan/hermon"
  url "https://github.com/DrazThan/hermon/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "a7e06a200f37888e0681ebf6524d6f662018ef6d19b98ed2c81ea9b7aaaffde2"
  license "MIT"
  head "https://github.com/DrazThan/hermon.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  service do
    run [opt_bin/"hermon", "menubar"]
    keep_alive true
    run_type :immediate
  end

  def post_install
    puts "
    ─────────────────────────────────────────────────────────
    hermon #{version} installed
    ─────────────────────────────────────────────────────────

    Get started:
      hermon watch          # TUI monitor
      hermon menubar        # Menu bar (requires X11 or Quartz display server)

    For launch-at-login (recommended):
      hermon menubar --install-login-item

    To uninstall launch-at-login:
      hermon menubar --uninstall-login-item
    "
  end

  test do
    assert_match "hermon #{version}", shell_output("#{bin}/hermon --version")

    # Point every source at a path with nothing in it: the roster must come up
    # empty rather than reading the test machine's real session stores.
    (testpath/"claude").mkpath
    output = shell_output("#{bin}/hermon ls " \
                          "--claude-dir #{testpath}/claude " \
                          "--hermes-db #{testpath}/absent-hermes.db " \
                          "--opencode-db #{testpath}/absent-opencode.db " \
                          "--hermes-log #{testpath}/absent-agent.log 2>&1")
    assert_match "0 session(s)", output
  end
end
