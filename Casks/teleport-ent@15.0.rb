cask "teleport-ent@15.0" do
  module Utils
    def self.version
      return "15.5.4"
    end
    def self.getsha
      require 'net/http'
      return Net::HTTP.get(URI("https://cdn.teleport.dev/teleport-ent-#{version}.pkg.sha256")).split()[0]
    end
  end

  version "#{Utils.version}"
  sha256 "#{Utils.getsha}"

  url "https://cdn.teleport.dev/teleport-ent-#{version}.pkg",
      verified: "cdn.teleport.dev"
  name "teleport-ent"
  desc "Teleport is a gateway for managing access to clusters of Linux servers via SSH or the Kubernetes API. Enterprise Edition"
  homepage "https://goteleport.com/"
  pkg "teleport-ent-#{version}.pkg"

  uninstall pkgutil: [
    "com.gravitational.teleport"
  ]

  conflicts_with formula: "teleport", cask: ["teleport", "teleport-ent@16.0", "teleport-ent@14.0", "teleport-ent"]

  caveats do
    license "https://dashboard.gravitational.com/web/"
  end
end
