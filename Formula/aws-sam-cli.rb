class AwsSamCli < Formula
  include Language::Python::Virtualenv

  desc "SAM command line interface"
  homepage "https://mysamwebpage.com/aws-sam-cli"
  url "https://github.com/awslabs/aws-sam-cli/archive/v0.6.0.tar.gz"
  sha256 "f85762aba829525eb8c6a52d354ef7254ed37e5bc8a7389885fd0daebfea1c96"
  head "https://github.com/TheSriram/aws-sam-cli.git", :branch => "develop"
  bottle do
    root_url "https://dl.bintray.com/thesriram/aws-sam-cli"
    cellar :any_skip_relocation
    rebuild 1
    sha256 "e861e50c9a0b5b595dd4c0a548796d05cc449aa64dc14e6a989e00ba92aa7700" => :sierra
    sha256 "8792b7889e53099e8dc63dab61e88bc0d039a277413b64bd3ab103ac8fbb8a1e" => :x86_64_linux
  end

  # Some AWS APIs require TLS1.2, which system Python doesn't have before High
  # Sierra
  depends_on "python"

  def install
    venv = virtualenv_create(libexec, "python3")
    system libexec/"bin/pip", "install", "-v", "--no-binary", ":all:",
                              "--ignore-installed", buildpath
    system libexec/"bin/pip", "uninstall", "-y", "aws-sam-cli"
    venv.pip_install_and_link buildpath
  end

  test do
    assert_match "Usage", shell_output("#{bin}/sam --help")
  end
end
