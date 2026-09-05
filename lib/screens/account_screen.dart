import 'package:assincronismo/models/account.dart';
import 'package:assincronismo/services/account_service.dart';
import 'dart:io';

class AccountScreen {
  final AccountService _accountService = AccountService();

  void initializeStream() {
    _accountService.streamInfos.listen(
      (event) {
        print(event);
      },
    );
  }

  void runChatBot() async {
    print("Bom dia!! Eu sou o Andre, assistente do Banco misterio");
    print("Que bom ter você aqui com a gente.\n");

    bool isRunning = true;
    while (isRunning){
      print("Como posso te ajudar? (digite o número desejado)");
      print("1 - Ver todas suas contas.");
      print("2 - Adicionar nova conta.");
      print("3 - sair\n");

      String? input = stdin.readLineSync();

      if (input != null){
        switch (input){
          case "1":
          {
            await _getAllAccounts();
            break;
          }
          case "2":
          {
            _addExampleAccount();
            break;
          }
          case "3":
          {
            isRunning = false;
            print("Te vejo na proxima");
            break;
          }
          default:
            print("Não entendi, tente novamente");
        }
      }
    }
  }

  Future<void> _getAllAccounts() async {
    List<Account> listAccounts = await _accountService.getAll();
    print(listAccounts);
  }

  void _addExampleAccount() async {
    Account example = Account(
      id: "ID555", 
      name: "Haley", 
      lastName: "Raven", 
      balance: 9000,
      );

      await _accountService.addAccount(example);
  }
}