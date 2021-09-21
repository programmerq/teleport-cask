cask "tsh" do
  version "7.1.3"
  sha256 "98ac2cc34233374e8ecea09bd0a5b88dbd3978532a7fd82776d2a92d31b2611e"

  url "https://get.gravitational.com/tsh-#{version}.pkg",
      verified: "get.gravitational.com"
  name "tsh"
  desc "Teleport is a gateway for managing access to clusters of Linux servers via SSH or the Kubernetes API. TSH client only"
  homepage "https://goteleport.com/"
  pkg "tsh-#{version}.pkg"

  uninstall pkgutil: [
    "com.gravitational.teleport.tsh"
  ]

  conflicts_with formula: "teleport", cask: ["teleport-ent", "teleport"]

  caveats do
    license "Apache-2.0"
  end
end
