data "template_file" "hosts" {
  template   = "${file("${path.module}/ansible/hosts.cfg")}"
  depends_on = [
    aws_instance.jenkins_master,
    aws_instance.jenkins_agent
  ]
  vars = {
    jenkins_master = "${join("\n", aws_instance.jenkins_master.*.public_ip)}"
    jenkins_agent  = "${join("\n", aws_instance.jenkins_agent.*.public_ip)}"
    monitoring  = "${join("\n", aws_instance.monitoring.*.public_ip)}"
    mysql  = "${join("\n", aws_instance.mysql.*.public_ip)}"
    elk = "${join("\n", aws_instance.elk.*.public_ip)}"

  }
}

resource "null_resource" "hosts" {
  triggers = {
    template_rendered = "${data.template_file.hosts.rendered}"
  }
  provisioner "local-exec" {
    interpreter = ["sh", "-c"]
    command     = "echo '${data.template_file.hosts.rendered}' > ./hosts"
  }
}