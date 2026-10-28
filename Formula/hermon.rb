class Hermon < Formula
  desc "Live monitor deck for AI agent sessions"
  homepage "https://github.com/DrazThan/hermon"
  url "https://github.com/DrazThan/hermon/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "c064331176f27989d96c93abb032da9a6f1a1c79ca5788bde22cbbdc1e3d449b"
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
