output "vpc_id" {
    value = aws_vpc.iti_vpc.id
    description = "value of vpc_id"
}

output "iti_public_subnet1_id" {
    value = aws_subnet.iti_public_subnet1.id
    description = "value of iti_public_subnet1_id"
}

output "iti_public_subnet2_id" {
    value = aws_subnet.iti_public_subnet2.id
    description = "value of iti_public_subnet2_id"
}

output "iti_private_subnet1_id" {
    value = aws_subnet.iti_private_subnet1.id
    description = "value of iti_private_subnet1_id"
}

output "iti_private_subnet2_id" {
    value = aws_subnet.iti_private_subnet2.id
    description = "value of iti_private_subnet2_id"
}

