class SummaryDTO {
  final int inputs;
  final int outputs;
  final int pending;
  final int absent;
  
  SummaryDTO({
    required this.inputs,
    required this.outputs,
    required this.pending,
    this.absent = 0
  });
}