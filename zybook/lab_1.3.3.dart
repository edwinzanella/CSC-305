import "dart:io";

void main(){
	print("Enter a string:");
	String str = stdin.readLineSync()!;

	print("Reversed String: ${reverseString(str)}");
	print("Is Palindrome: ${isPalindrome(str)}");
}

String reverseString(String str){
	String reversed = "";
	for(int i = str.length - 1; i >= 0; i--){
		reversed += str[i];
	}
	return reversed;
}

String isPalindrome(String str){
	String reversed = reverseString(str);
	if(str == reversed){
		return "Yes";
	}
	else{
		return "No";
	}
}