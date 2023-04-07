class PaymentTranslator {
  static String translator(String? result) {
    if (result == 'pending') return 'Pagamento Pendente';
    if (result == 'approved') return 'Pagamento Aprovado';
    if (result == 'authorized') {
      return 'Pagamento autorizado, aguardando confirmacao';
    }
    if (result == 'in_process') return 'Pagamento em analise';
    if (result == 'rejected') return 'Pagamento Negado';
    return '';
  }
}
