solidez de pragma 0,4.25;
Detalhes
contrato Eleicao {

    struct Candidato {
        string nome;
        endereço conta;
        uint numeroVotos;
        bool existe;
    }

    mapeamento (endereço => Candidato) candidatos;

    função incluiCandidato (string nomeCandidato, endereço contaCandidato) public {
        Candidato memory novoCandidato = Candidato (nomeCandidato, contaCandidato, 0, true);
        candidatos [contaCandidato] = novoCandidato;
    }
    
    função pesquisarCandidato (endereço contaCandidato) public view retorna (string, endereço, uint) {
        Candidato memória candidato = candidato [contaCandidato];
        if (candidato.existe == true) {
            return (candidato.nome, candidato.conta, candidato.numeroVotos);
        } outro {
            return ("", 0, 0);
        }
    }
}

// Implantado: https://rinkeby.etherscan.io/address/0x5b14487517c1684380fe0f74bc299f77b0a0a3d3#code
