resource "aws_instance" "web" {
  ami                    = "ami-02a2af70a66af6dfb"
  instance_type          = "t2.micro"
  key_name               = "amazonlinux"
  vpc_security_group_ids = [aws_security_group.sg.id]
  tags = {
    "Name" = "terraform"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("amazonlinux.pem") # Update with the path to your private key
    host        = aws_instance.web.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "sudo yum update",
      "sudo yum install httpd -y",
      "wget https://www.free-css.com/assets/files/free-css-templates/download/page290/wave-cafe.zip",
      "sudo unzip wave-cafe.zip",
      "sudo mv 2121_wave_cafe /var/www/html/"
    ]
  }
}