cask "teleport-ent" do
  version "7.3.15"
  sha256 "2f91c51913ce06c34d485cedd725a822da8e895a40997a097d72abf43e09761c"

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
