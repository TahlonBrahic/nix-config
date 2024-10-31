{
  programs.starship = {
    enable = true;
    settings = {
      aws.disabled = true;
      gcloud.disabled = true;
      kubernetes.disabled = false;
      git_branch.style = "242";
      directory = {
        style = "blue";
        truncate_to_repo = false;
        truncation_length = 8;
      };
      python.disabled = true;
      ruby.disabled = true;
      hostname.ssh_only = false;
      hostname.style = "bold green";
    };
  };
}
