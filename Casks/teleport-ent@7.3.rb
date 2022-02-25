cask "teleport-ent" do
  version "7.3.16"
  sha256 "ae27bd2b06944624598c894a989d44686d20ef8d96cb3b21c79a76a6b22ae74b"

  url "https://get.gravitational.com/teleport-ent-#{version}.pkg",
      verified: "get.gravitational.com"
  name "teleport-ent"
  desc "Teleport is a gateway for managing access to clusters of Linux servers via SSH or the Kubernetes API. Enterprise Edition"
  homepage "https://goteleport.com/"
  pkg "teleport-ent-#{version}.pkg"

  uninstall pkgutil: [
    "com.gravitational.teleport"
  ]

  conflicts_with formula: "teleport", cask: ["teleport", "tsh", "teleport-ent@7.0"]

  caveats do
    license "https://dashboard.gravitational.com/web/"
  end
end
