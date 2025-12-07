1. CENÁRIO – Sistema de Clínica Veterinária Vida Animal

A Clínica Veterinária Vida Animal é uma empresa localizada na cidade de Franca – São Paulo, especializada no atendimento clínico, cirúrgico e preventivo de animais domésticos. A clínica atende principalmente cachorros, gatos, pássaros, coelhos e pequenos animais, possuindo um fluxo diário de clientes que buscam consultas, vacinas, cirurgias, exames e cuidados gerais.

Com o crescimento da clínica, a administração começou a enfrentar dificuldades para controlar informações sobre clientes, animais, veterinários, serviços oferecidos e consultas realizadas. Antes, todo o processo era feito manualmente, causando problemas como:

Perda de fichas de atendimento

Dificuldade para localizar histórico de consultas

Serviços cobrados sem controle adequado

Atraso no agendamento e falha na comunicação com os clientes

Falta de integração entre os setores

Diante disso, surgiu a necessidade de criar um Sistema de Gerenciamento de Clínica Veterinária, capaz de organizar todas as informações em um banco de dados centralizado, confiável e fácil de consultar.

🧩 ENTIDADES IDENTIFICADAS

No cenário da clínica, foram identificadas 5 entidades principais, cada uma representando um conjunto de informações essenciais para o funcionamento do sistema:

Cliente

Animal

Veterinário

Serviço

Consulta

Consulta_Serviço (tabela associativa)

São 5 entidades principais + 1 entidade associativa para o relacionamento N:N.

🔍 ATRIBUTOS DAS ENTIDADES (Com todos os tipos exigidos)
1) Cliente

Atributos:

id (PK) → chave primária

nome (simples)

email (simples)

endereço (composto: rua, número, bairro, cidade, estado)

telefones (multivalorado: array)

created_at (derivado automaticamente do sistema)

2) Veterinário

id (PK)

nome (simples)

especialidade (simples)

telefones (multivalorado)

created_at (derivado)

3) Animal

id (PK)

id_cliente (FK) → relacionamento 1:N

nome (simples)

especie (simples)

raca (simples)

data_nascimento (simples)

microchip (simples)

idade (derivado) → pode ser calculado pela data de nascimento

created_at (derivado)

4) Serviço

id (PK)

nome

valor

created_at (derivado)

5) Consulta

id (PK)

id_animal (FK) → 1:N

id_veterinario (FK) → 1:N

data

tipo

status

diagnostico

created_at

6) Consulta_Serviço (tabela N:N)

id_consulta (FK)

id_servico (FK)

Relaciona vários serviços aplicados em uma única consulta

🔗 RELACIONAMENTOS (todos obrigatórios incluídos)
1:N (Um para Muitos)

Cliente → Animal
Um cliente pode ter vários animais.
Um animal pertence a apenas um cliente.

Veterinário → Consulta
Um veterinário realiza várias consultas.
Uma consulta é feita por um único veterinário.

Animal → Consulta
Um animal pode ter várias consultas ao longo da vida.
Uma consulta pertence a apenas um animal.

N:N (Muitos para Muitos)

Consulta ↔ Serviço
Uma consulta pode incluir vários serviços (ex: vacina + exame).
Um serviço pode aparecer em várias consultas.
→ Criado através da tabela consulta_servico

1:1 (Um para Um)

Aqui podemos considerar:

Animal ↔ Microchip
Cada animal tem um microchip único.
Cada microchip pertence a um único animal.
(Mesmo armazenado como atributo simples, conceitualmente é 1:1 porque é único.)

🎯 PROBLEMA QUE O SISTEMA RESOLVE

O sistema foi criado para:

Organizar e registrar todos os atendimentos realizados

Evitar perda de informações importantes

Melhorar o controle financeiro dos serviços

Facilitar o agendamento e visualização das consultas

Registrar o histórico completo dos animais

Tornar o atendimento mais rápido e eficiente

Com esse banco de dados, a clínica ganha:

Rapidez na busca de informações

Segurança nos dados

Histórico completo dos animais

Controle dos serviços prestados

Organização dos profissionais e seus atendimentos