import 'dart:io';

void main() {
  print('Insira o número do cartão: ');
  var creditCard = stdin.readLineSync();
  print('---------------------------');

  if (creditCard != null) {
    //.replaceAll() é um método de string que troca os espaços em branco (ou outros caracteres que forem definidos)
    //por uma string vazia.
    //Ele necessita de teste para verificar se o valor passado é nulo ou não, senão o Dart não aceita utilizar
    //o método devido ao null safety
    mod10(creditCard.replaceAll(' ', ''));
  } else {
    print('insira um número de cartão válido');
  }
}

mod10(String card) {
  //Variável que irá receber a lista dos números para serem somados
  List<int> cardNumbersX = [];
  //Variável que pega a soma da lista acima, utilizo a tipagem num pois em algumas operações ela será tratada
  //como integer e em outras como double
  num result = 0;

  //Separa o último número do cartão - poderia utilizar 15 como valor por ser um cartão de crédito/débito
  int lastNumber = int.parse(card.substring(card.length - 1));

  //itera a lista de números, faz a multiplicação dos números de coluna par e coloca tudo numa lista
  for (var i = 0; i < card.length - 1; i++) {
    //checa se a coluna é par ou impar
    if (i.isEven) {
      // odd / even = impar / par
      //se a coluna for par, multiplica o número por 2
      int addNumber = int.parse(card[i]) * 2;

      //se o resultado da multiplicação for dois dígitos, soma os dois, senão só adiciona à lista
      if (addNumber > 9) {
        //Divide a int em uma Lista de Strings (a classe int não contém o método split)
        List<String> dividedNumber = addNumber.toString().split('');

        //Soma os dois elementos, transformando eles em int
        int sum = dividedNumber.fold<int>(0, (a, b) => a + int.parse(b));

        //adiciona o resultado da soma na lista
        cardNumbersX.add(sum);
      } else {
        //se o resultado da multiplicação for menor que dois dígitos, adiciona na lista
        cardNumbersX.add(addNumber);
      }
    } else {
      //se a coluna for ímpar, mantém o digito como está
      cardNumbersX.add(int.parse(card[i]));
    }
  }

  //itera a lista (forEach element) e com uma função anônima soma o total dos números da lista
  cardNumbersX.forEach((element) => result = result + element);

  //Com o resultado anterior, faz uma divisão por 10 com o operador de módulo para obter o resto da divisão:
  //em seguida, divide o resto da divisão por 10
  result = (10 - result % 10) % 10;

  //validação do cartão: se o resultado acima for igual ao último número do cartão, então este é válido
  if (result == lastNumber) {
    print(result);
    print(lastNumber);
    print('Cartão válido');
  } else {
    print(result);
    print(lastNumber);
    print('cartão Inválido');
  }
}
