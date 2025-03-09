import 'dart:io';

void main(){
    print("Enter the first integer:");
    int first = int.parse(stdin.readLineSync()!);

    print("Enter the second integer:");
    int second = int.parse(stdin.readLineSync()!);

    print("Addition: ${first + second}");
    print("Subtraction: ${first - second}");
    print("Multiplication: ${first * second}"); 
    print("Division: ${first ~/ second}"); 
    print("Modulus: ${first % second}");

    if(first > second){
        print("$first is greater than $second.");
    }
    else if (second > first){
        print("$second is greater than $first.");
    }
    else {
        print("Both numbers are equal.");
    }
}