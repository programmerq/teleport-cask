cask "teleport-ent@7.3" do
  version "7.3.22"
  sha256 "77fdff1461c6342b3499cbd7ec2d46d6015b19ea8d6ccb311b3d8b9a5c2806b8"

  url "https://get.gravitational.com/teleport-ent-#{version}.pkg",
      verified: "get.gravitational.com"
  name "teleport-ent"
  desc "Teleport is a gateway for managing access to clusters of Linux servers via SSH or the Kubernetes API. Enterprise Edition"
  homepage "https://goteleport.com/"
  pkg "teleport-ent-#{version}.pkg"

  uninstall pkgutil: [
    "com.gravitational.teleport"
  ]

  conflicts_with formula: "teleport", cask: ["teleport", "tsh", "teleport-ent@7.0", "teleport-ent@7.1", "teleport-ent@7.2"]

  caveats do
    license "https://dashboard.gravitational.com/web/"
  end
end
