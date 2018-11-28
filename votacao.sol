solidez de pragma 0,4.25;

contrato AssembleiaGeralSocios {

    struct Proposta {
        string texto;
        endereço proponente;
        uint quotaDeVotos;
        uint quotaMinimaParaAprovacao;
        bool existe;
    }

    struct Votante {
        endereço conta;
        uint quotaDeVotos;
        bool votou;
        bool existe;
    }

    modificador somenteChairman () {
        require (chairman == msg.sender, "Só o Chairmain pode levantar essa operação");
        _;
    }

    // Informações gerais da Assembleia
    Proposta [] propostas;
    mapeamento (endereço => Votante) votantes;
    endereço presidente;
    uint dataInicioVotacao;
    uint dataFimVotacao;
    string anoExercício;

    construtor (cadeia qualAnoExercicio, uint qualDataFimVotacao) public {
        chairman = msg.sender;
        dataFimVotacao = qualDataFimVotacao;
        anoExercício = qualAnoExercício;
    }

    função incluídosVotante (endereço enderecoVotante, uint quotaDeVotos) public somenteChairman {
        require (quotaDeVotos <= 99, "Quota não pode ser superior a 99%");
        require (enderecoVotante! = endereço (0), "O votante deve ter um endereco valido");
        Memória Votante novoVotante = Votante (enderecoVotante, quotaDeVotos, false, true);
        votantes [enderecoVotante] = novoVotante;
    }

    function incluiProposta (string qualTextoDaProposta, endereço qualProponente, uint qualQuotaMinimaParaAprovacao) public somenteChairman {
        Proposta memória novaProposta = Proposta (qualTextoDaProposta, qualProponente, 0, qualQuotaMinimaParaAprovacao, true);
        imagens.push (novaProposta);
    }
    
    função pesquisarVotante (endereço indiceVotante) public view returns (endereço, uint) {
        Votante memory votanteTemporario = votantes [indiceVotante];
        if (votanteTemporario.existe == true) {
            return (votanteTemporario.conta, votanteTemporario.quotaDeVotos);
        } outro {
            retorno (0,0);
        }
    }

    função pesquisarProposta (uint numeroProposta) public view retorna (string, endereço, uint, uint) {
        Proposta memory propostaTemporario = propostas [numeroProposta];
        if (propostaTemporario.existe) {
            return (propostaTemporario.texto, propostaTemporario.proponente, propostaTemporario.quotaDeVotos, propostaTemporario.quotaMinimaParaAprovacao);
        } outro {
            return ("", 0, 0, 0);
        }
    }

    função totalDePropostas () public view retorna (uint) {
        return propostas.length;
    }

    função qualAnoExercicio () public view retorna (string) {
        return anoExercicio;
    }

    função propostaAprovada (uint numeroProposta) public view returns (bool) {
        Proposta memory propostaTemporario = propostas [numeroProposta];
        if (propostaTemporario.existe) {
            voltar propostaTemporario.quotaDeVotos> = propostaTemporario.quotaMinimaParaAprovacao;
        } outro {
            retorna falso;
        }
    }

    function quandoEncerraVotacao () public view retorna (uint) {
        return dataFimVotacao;
    }

    function votar (uint numeroProposta, bool favoravelAProposta) retornos públicos (bool) {
        require (dataFimVotacao> = agora, "Votacao encerrada");
        Proposta storage propostaTemporario = propostas [numeroProposta];
        if (propostaTemporario.existe) {
            Votante storage votanteTemporario = votantes [msg.sender];
            if (votanteTemporario.existe == true) {
                if (votanteTemporario.votou == false) {
                    if (favoravelAProposta == true) {
                        propostaTemporario.quotaDeVotos = propostaTemporario.quotaDeVotos + votanteTemporario.quotaDeVotos;
                    }
                    votanteTemporario.votou = true;
                    retorno verdadeiro;
                } 
            } 
        } 
        retorna falso;
    }
}
