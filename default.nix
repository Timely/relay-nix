# default.nix
{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "relay";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "webhookrelay";
    repo = "relay-go";
    rev = "5c89c01";
    hash = "sha256-9B0TixeMDDf5icbwLS54KXDfv2ARmvktkEl1VVRENlM=";
  };

  vendorHash = null; # Will be generated on first build attempt

  subPackages = [ "cmd/relayd" ];

  ldflags = [
    "-s"
    "-w"
    "-X github.com/webhookrelay/relay-go/version.Version=${version}"
    "-X github.com/webhookrelay/relay-go/version.Revision=${src.rev}"
    "-X github.com/webhookrelay/relay-go/version.BuildDate=1970-01-01T00:00:00Z" # Static date for reproducibility
  ];

  # Optional: Skip tests if they require network access or special setup
  doCheck = false;

  meta = with lib; {
    mainProgram = "relayd";
    description = "Webhook Relay daemon";
    homepage = "https://github.com/webhookrelay/relay-go";
    license = licenses.mpl20;
    maintainers = [ ];
  };
}
