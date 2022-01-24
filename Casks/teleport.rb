cask "teleport" do
  version "8.1.0"
  sha256 "b43cfa282b29dfdf9d25768466644dfe8bef02f4ee68559fd40cd514900e6337"

  url "https://get.gravitational.com/teleport-#{version}.pkg",
      verified: "get.gravitational.com"
  name "teleport"
  desc "Teleport is a gateway for managing access to clusters of Linux servers via SSH or the Kubernetes API"
  homepage "https://goteleport.com/"
  pkg "teleport-#{version}.pkg"

  uninstall pkgutil: [
    "com.gravitational.teleport"
  ]

  conflicts_with formula: "teleport", cask: ["teleport-ent", "tsh"]

  caveats do
    license "Apache-2.0"
  end
end
