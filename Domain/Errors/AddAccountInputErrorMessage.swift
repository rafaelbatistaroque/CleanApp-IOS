import Foundation

public enum AddAccountInputErrorMessage: String {
    case requiredName = "O campo Nome é obrigatório",
    requiredEmail = "O campo Email é obrigatório",
    invalidEmail = "O campo Email é inválido",
    requiredPassword = "O campo Senha é obrigatório",
    requiredPasswordConfirmation = "O campo Confirmação de Senha é obrigatório",
    failPasswordConfirmation = "Falha ao confirmar senha"
}
