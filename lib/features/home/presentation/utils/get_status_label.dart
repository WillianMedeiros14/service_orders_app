String getStatusLabel(String status) {
  switch (status) {
    case "OPEN":
      return "ABERTA";
    case "IN_PROGRESS":
      return "EM ANDAMENTO";
    case "FINISHED":
      return "FINALIZADA";
    default:
      return "Desconhecido";
  }
}
