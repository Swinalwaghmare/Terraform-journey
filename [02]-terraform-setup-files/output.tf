output instance_name {
    value = aws_instance.name.tags.Name
}

output instance_ami {
    value = aws_instance.name.ami
}