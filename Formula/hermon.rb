class Hermon < Formula
  desc "Live monitor deck for AI agent sessions"
  homepage "https://github.com/DrazThan/hermon"
  url "https://github.com/DrazThan/hermon/archive/refs/tags/v0.4.1.tar.gz"
  sha256 "5399953d0b2e313c4b766e02b25bf22c007e1fcb65e689c06a520d08a6d49871"
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
