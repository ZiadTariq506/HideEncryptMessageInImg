import string 

cipher_text = input("") 
if cipher_text == "":
	print("wrong password!!!")
else: 
	shift = 26-7
	# to make the en chracters like a loop
	shift %= 26

	alphabet = string.ascii_lowercase

	shifted = alphabet[shift:] + alphabet[:shift]

	table = str.maketrans(alphabet, shifted)

	decrypted = cipher_text.translate(table)

	print(decrypted)