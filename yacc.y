%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>  
#include <math.h>
#include <stdarg.h>

#define MAX_VOOS 20
#define MAX_RESERVAS 5

typedef struct {
    char origem[50];
    char destino[50];
    char data[20];
    int numero;
    char aeroporto_saida[50];
    char aeroporto_chegada[50];
    char duracao[10];
    char horario_saida[10];
} Voo;

typedef struct {
    int numero_voo;
} Reserva;

Voo voos[MAX_VOOS];
int num_voos = 0;

Reserva reservas[MAX_RESERVAS];
int num_reservas = 0;

void yyerror(const char *s);
int yylex(void);
void cadastrar_voos(void);
void listar_voos(void);
void reservar_voo(int numero_voo);
void cancelar_reserva(int numero_reserva);
void imprimir_opcoes(void);
void listar_reservas(void);
void detalhe_reserva(int numero_reserva);

typedef union {
    int num;
    char *id;
} YYSTYPE;

#define YYSTYPE_IS_DECLARED 1

%}

%union {
    int num;
    char *id;
}

%token PROCURAR VOOS RESERVAR NUMERO CANCELAR RESERVA VERIFICAR AJUDA LISTAR RESERVAS DETALHES SAIR
%token <num> NUM
%token <id> ID


%%
/* Regras Gramaticais e Ações Semânticas */
input: /* vazio */
 | input line
;

line: '\n'
 | comando '\n'
 | error '\n' { yyerrok; }
;

comando: pesquisar
       | reservar
       | cancelar
       | ajuda
       | detalhes
       | listar
       | sair
       ;

pesquisar: PROCURAR VOOS {
    listar_voos();
}

reservar: RESERVAR NUMERO NUM {
    reservar_voo($3);
}

cancelar: CANCELAR RESERVA NUM {
    cancelar_reserva($3);
}

listar : LISTAR RESERVAS {
    listar_reservas();
}

ajuda: AJUDA {
    imprimir_opcoes();
}

detalhes: DETALHES NUM {
    detalhe_reserva($2);
}

sair: SAIR {
    printf("\t\t\tSaindo ...\n");
    exit(0);
}


%%

void yyerror(const char *s) {
    fprintf(stderr, "Erro: %s\n", s);
}

void cadastrar_voos(void) {
    voos[num_voos++] = (Voo){"São Paulo", "Rio de Janeiro", "20/07/2024", 12345, "Aeroporto de Congonhas", "Aeroporto Santos Dumont", "1h", "08:00"};
    voos[num_voos++] = (Voo){"São Paulo", "Belo Horizonte", "21/07/2024", 12346, "Aeroporto de Congonhas", "Aeroporto de Confins", "1h 10m", "09:00"};
    voos[num_voos++] = (Voo){"Rio de Janeiro", "Brasilia", "22/07/2024", 12347, "Aeroporto Santos Dumont", "Aeroporto de Brasília", "1h 30m", "10:00"};
    voos[num_voos++] = (Voo){"Brasilia", "Salvador", "23/07/2024", 12348, "Aeroporto de Brasília", "Aeroporto de Salvador", "2h", "11:00"};
    voos[num_voos++] = (Voo){"Salvador", "Recife", "24/07/2024", 12349, "Aeroporto de Salvador", "Aeroporto de Recife", "1h", "12:00"};
    voos[num_voos++] = (Voo){"Recife", "Fortaleza", "25/07/2024", 12350, "Aeroporto de Recife", "Aeroporto de Fortaleza", "1h 10m", "13:00"};
    voos[num_voos++] = (Voo){"Fortaleza", "Natal", "26/07/2024", 12351, "Aeroporto de Fortaleza", "Aeroporto de Natal", "1h", "14:00"};
    voos[num_voos++] = (Voo){"Natal", "João Pessoa", "27/07/2024", 12352, "Aeroporto de Natal", "Aeroporto de João Pessoa", "45m", "15:00"};
    voos[num_voos++] = (Voo){"João Pessoa", "Maceió", "28/07/2024", 12353, "Aeroporto de João Pessoa", "Aeroporto de Maceió", "1h", "16:00"};
    voos[num_voos++] = (Voo){"Maceió", "Aracaju", "29/07/2024", 12354, "Aeroporto de Maceió", "Aeroporto de Aracaju", "1h", "17:00"};
    voos[num_voos++] = (Voo){"Aracaju", "Salvador", "30/07/2024", 12355, "Aeroporto de Aracaju", "Aeroporto de Salvador", "1h", "18:00"};
    voos[num_voos++] = (Voo){"Salvador", "Brasilia", "31/07/2024", 12356, "Aeroporto de Salvador", "Aeroporto de Brasília", "2h", "19:00"};
    voos[num_voos++] = (Voo){"Brasilia", "Rio de Janeiro", "01/08/2024", 12357, "Aeroporto de Brasília", "Aeroporto Santos Dumont", "1h 30m", "20:00"};
    voos[num_voos++] = (Voo){"Rio de Janeiro", "São Paulo", "02/08/2024", 12358, "Aeroporto Santos Dumont", "Aeroporto de Congonhas", "1h", "21:00"};
    voos[num_voos++] = (Voo){"São Paulo", "Curitiba", "03/08/2024", 12359, "Aeroporto de Congonhas", "Aeroporto de Curitiba", "1h", "22:00"};
    voos[num_voos++] = (Voo){"Curitiba", "Porto Alegre", "04/08/2024", 12360, "Aeroporto de Curitiba", "Aeroporto de Porto Alegre", "1h 30m", "23:00"};
    voos[num_voos++] = (Voo){"Porto Alegre", "Florianópolis", "05/08/2024", 12361, "Aeroporto de Porto Alegre", "Aeroporto de Florianópolis", "1h", "00:00"};
    voos[num_voos++] = (Voo){"Florianópolis", "Curitiba", "06/08/2024", 12362, "Aeroporto de Florianópolis", "Aeroporto de Curitiba", "1h", "01:00"};
    voos[num_voos++] = (Voo){"Curitiba", "São Paulo", "07/08/2024", 12363, "Aeroporto de Curitiba", "Aeroporto de Congonhas", "1h", "02:00"};
    voos[num_voos++] = (Voo){"São Paulo", "Rio de Janeiro", "08/08/2024", 12364, "Aeroporto de Congonhas", "Aeroporto Santos Dumont", "1h", "03:00"};
}

void listar_voos(void) {
    printf("\t\t\t\tVoos disponíveis:\n\n");
    for (int i = 0; i < num_voos; i++) {
        printf("\t\t\t\tVoo %d: %s -> %s em %s (Número: %d)\n", 
               i+1, voos[i].origem, voos[i].destino, voos[i].data, voos[i].numero);
    }
    printf("\n");
}

void reservar_voo(int numero_voo) {
    printf("\t\t\t\tReservando...\n");
    int encontrado = 0;
    for (int i = 0; i < num_voos; i++) {
        if (voos[i].numero == numero_voo) {   
            encontrado = 1;
            // Registrar a reserva
            if (num_reservas < MAX_RESERVAS) {
                reservas[num_reservas].numero_voo = numero_voo;
                num_reservas++;
                printf("\t\t\t\tReserva realizada com sucesso.\n");
            } else {
                printf("\t\t\t\tLimite de reservas atingido.\n");
            }
            break;
        }
    }
    if (!encontrado) {
        printf("\t\t\t\tErro: O voo %d não está disponível para reserva.\n", numero_voo);
    }
}

void cancelar_reserva(int numero_reserva) {
    int encontrado = 0;
    printf("\t\t\t\tCancelando ...\n");
    // Procurar a reserva na lista de reservas
    for (int i = 0; i < num_reservas; i++) {
        if (reservas[i].numero_voo == numero_reserva) {
            encontrado = 1;
            // Remover a reserva da lista e decrementar o contador 
            for (int j = i; j < num_reservas - 1; j++) {
                reservas[j] = reservas[j + 1];
            }
            num_reservas--;
            printf("\t\t\t\tReserva %d cancelada com sucesso.\n", numero_reserva);
            break;
        }
    }
    
    if (!encontrado) {
        printf("\t\t\t\tErro: Reserva %d não encontrada.\n", numero_reserva);
    }
}

void listar_reservas(void) {
    if (num_reservas == 0) {
        printf("\t\t\t\tNenhuma reserva feita.\n");
        return;
    }

    printf("Reservas feitas:\n");
    for (int i = 0; i < num_reservas; i++) {
        printf("\t\t\t\tReserva %d: Voo número %d\n", i + 1, reservas[i].numero_voo);
    }

}

void detalhe_reserva(int numero_voo) {
    int encontrado = 0;
    for (int i = 0; i < num_voos; i++) {
        if (voos[i].numero == numero_voo) {
            printf("\t\t\t\tDetalhes do voo %d\n", numero_voo);
            printf("\t\t\t\t    Origem: %s\n", voos[i].origem);
            printf("\t\t\t\t    Destino: %s\n", voos[i].destino);
            printf("\t\t\t\t    Data: %s\n", voos[i].data);
            printf("\t\t\t\t    Aeroporto de saída: %s\n", voos[i].aeroporto_saida);
            printf("\t\t\t\t    Aeroporto de chegada: %s\n", voos[i].aeroporto_chegada);
            printf("\t\t\t\t    Duração: %s\n", voos[i].duracao);
            printf("\t\t\t\t    Horário de saída: %s\n", voos[i].horario_saida);
            encontrado = 1;
            break;
        }
    }
    if (!encontrado) {
        printf("\t\t\t\tErro: O voo número %d não está disponível.\n", numero_voo);
    }
}

void imprimir_opcoes(void) {
    printf("\t\t\t\tOpções disponíveis:\n\n");
    printf("\t\t\t\t[] PROCURAR VOOS : Lista os voos disponíveis\n");
    printf("\t\t\t\t[] RESERVAR NUMERO <numero_do_voo>: fazer a reserva do voo  pelo numero \n");
    printf("\t\t\t\t[] CANCELAR RESERVA <numero_do_voo>: cancelar a reserva pelo numero de voo\n");
    printf("\t\t\t\t[] LISTAR RESERVAS: lista todas as reservas feitas\n");
    printf("\t\t\t\t[] AJUDA: Mostra os comandos e as ações dos comandos\n");
    printf("\t\t\t\t[] DETALHES <numero_do_voo>: Mostra mais detalhes sobre um determinado voo\n");
    printf("\t\t\t\t[] SAIR: Sair do programa\n");
}

int main(void) {
    imprimir_opcoes();
    cadastrar_voos();
    yyparse();
    return 0;
}

int yylex(void) {
    int c;
    char buffer[256];  // Buffer para armazenar identificadores

    // Ignorar espaços em branco
    while ((c = getchar()) == ' ' || c == '\t');

    // Verificar dígitos
    if (c == EOF) return 0;
    if (c >= '0' && c <= '9') {
        ungetc(c, stdin);
        scanf("%d", &yylval.num);
        return NUM;
    }

    // Verificar identificadores
    if (isalpha(c)) {
        int i = 0;
        do {
            buffer[i++] = tolower(c);  
            c = getchar();
        } while (isalnum(c) && i < sizeof(buffer) - 1);
        buffer[i] = '\0';
        ungetc(c, stdin);  

        yylval.id = strdup(buffer);
        if (strcmp(yylval.id, "procurar") == 0) return PROCURAR;
        if (strcmp(yylval.id, "voos") == 0) return VOOS;
        if (strcmp(yylval.id, "reservar") == 0) return RESERVAR;
        if (strcmp(yylval.id, "numero") == 0) return NUMERO;
        if (strcmp(yylval.id, "cancelar") == 0) return CANCELAR;
        if (strcmp(yylval.id, "reserva") == 0) return RESERVA;
        if (strcmp(yylval.id, "ajuda") == 0) return AJUDA;
        if (strcmp(yylval.id, "listar") == 0) return LISTAR;
        if (strcmp(yylval.id, "reservas") == 0) return RESERVAS;
        if (strcmp(yylval.id, "detalhes") == 0) return DETALHES;
        if (strcmp(yylval.id, "sair") == 0) return SAIR;
        return ID;
    }
    
    return c;
}
