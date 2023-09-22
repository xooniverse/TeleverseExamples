import 'dart:io';

void main(List<String> args) async {
  final files = Directory("lib").listSync(recursive: true);
  final examples = files.where((e) => e.path.endsWith(".dart")).toList();
  print("Examples: ");
  for (var i = 0; i < examples.length; i++) {
    print("   ${i + 1}. ${examples[i].path.split("/").last}");
  }

  stdout.write("Enter the example number: ");
  final input = stdin.readLineSync();

  if (input == null) {
    print("Invalid input");
    return;
  }

  final index = int.tryParse(input);
  if (index == null) {
    print("Invalid input");
    return;
  }

  if (index < 1 || index > examples.length) {
    print("Invalid input");
    return;
  }

  final example = examples[index - 1];
  final name = example.path.split("/").last;

  print("Running $name...");
  await Process.run("dart", [example.path]);
  print("Done!");
}
