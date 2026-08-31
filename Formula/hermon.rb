class Hermon < Formula
  desc "Live monitor deck for Hermes, Claude Code, and OpenCode agent sessions"
  homepage "https://github.com/DrazThan/hermon"
  url "https://github.com/DrazThan/hermon/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "df17d70b2593c9fb5d4b6f7706949141d44ae8ee4e58af4e24e78cc0c86cfa87"
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
