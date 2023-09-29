export const getImage = (description: string): string | undefined => {
  if (description.toLowerCase().includes("terraform")) {
    return "./images/terraform.svg";
  } else if (description.toLowerCase().includes("s3")) {
    return "./images/aws-s3.svg";
  } else if (description.toLowerCase().includes("ec2")) {
    return "./images/aws-ec2.svg";
  } else if (description.toLowerCase().includes("rds")) {
    return "./images/aws-rds.svg";
  } else if (description.toLowerCase().includes("docker")) {
    return "./images/docker.svg";
  } else if (description.toLowerCase().includes("cloudwatch")) {
    return "./images/cloudwatch.svg";
  } else {
    return undefined;
  }
};
