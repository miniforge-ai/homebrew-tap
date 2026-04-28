class Miniforge < Formula
  desc "Autonomous software factory — built on MiniForge Core"
  homepage "https://miniforge.ai"
  version "2026.04.26.1"
  license "Apache-2.0"

  on_macos do
    url "https://github.com/miniforge-ai/miniforge/releases/download/v2026.04.26.1/miniforge-macos-arm64"
    sha256 "aa5053712342085e5a8496447edc5425940c64721e00d31a45cfdbcac0ce10d9"
  end

  on_linux do
    url "https://github.com/miniforge-ai/miniforge/releases/download/v2026.04.26.1/miniforge-linux-x86_64"
    sha256 "a1749443d7799748d960fc866bfd4250d76907f1f3fea6519c8bb6a6955c85a2"
  end

  depends_on "babashka"

  def install
    jar_name = "miniforge.jar"
    if OS.mac?
      libexec.install "miniforge-macos-arm64" => jar_name
    else
      libexec.install "miniforge-linux-x86_64" => jar_name
    end

    (bin/"mf").write <<~SH
      #!/bin/bash
      exec bb --jar "#{libexec}/#{jar_name}" -m ai.miniforge.cli.main "$@"
    SH
  end

  test do
    assert_match "miniforge", shell_output("#{bin}/mf --help 2>&1")
  end
end
