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

<img width="1536" height="1024" alt="image" src="https://github.com/user-attachments/assets/f59fe6e7-c434-410b-a7f3-3230ed14e576" />

<img width="1102" height="552" alt="image" src="https://github.com/user-attachments/assets/c594f6d3-dca3-43d8-ae5a-1d5fa2d9f017" />

<img width="996" height="662" alt="image" src="https://github.com/user-attachments/assets/28805c13-7b2a-47b0-9949-76162c930dfd" />

<img width="1452" height="703" alt="image" src="https://github.com/user-attachments/assets/b4b03d8a-0fde-41bb-88fa-b5aeda74d496" />

<img width="1450" height="647" alt="image" src="https://github.com/user-attachments/assets/6be071a2-42d9-4be7-959c-c655f99a9f26" />

<img width="1447" height="682" alt="image" src="https://github.com/user-attachments/assets/42fedf71-5f02-4a53-bf58-96adcb2d577a" />

<img width="1418" height="676" alt="image" src="https://github.com/user-attachments/assets/dd01efad-1012-4d01-ac95-c7ecdbef92af" />

<img width="872" height="726" alt="image" src="https://github.com/user-attachments/assets/1f40223d-74ca-49f9-8d81-debbca3ad6d3" />

<img width="727" height="703" alt="image" src="https://github.com/user-attachments/assets/0953de27-8bc1-44c0-b62f-56dbc979f3fd" />

<img width="846" height="683" alt="image" src="https://github.com/user-attachments/assets/cf5f5aa8-799f-44cc-9cab-d224d181854a" />

<img width="1008" height="716" alt="image" src="https://github.com/user-attachments/assets/c3e6f384-8d13-4b21-bfaf-6cee77f70d01" />

<img width="980" height="717" alt="image" src="https://github.com/user-attachments/assets/e1157c0c-4033-4329-9186-b145e050dbf8" />

<img width="1430" height="718" alt="image" src="https://github.com/user-attachments/assets/181c0669-85e7-4162-adb3-342d562a6bfd" />

<img width="1430" height="718" alt="image" src="https://github.com/user-attachments/assets/36746ec7-0eac-4d1a-9a17-4d3c72e4331d" />

<img width="917" height="712" alt="image" src="https://github.com/user-attachments/assets/9d499b6f-7825-4288-b6e8-5462c2844932" />

<img width="917" height="712" alt="image" src="https://github.com/user-attachments/assets/f93888e6-76d6-4f61-8fc0-5c71018d8633" />

<img width="917" height="712" alt="image" src="https://github.com/user-attachments/assets/def838da-0361-4a20-b883-0008ac070cd5" />

<img width="787" height="727" alt="image" src="https://github.com/user-attachments/assets/55b5e67f-e053-4822-ab7a-174569486d19" />

<img width="772" height="523" alt="image" src="https://github.com/user-attachments/assets/eed87ca3-8edc-4f4e-9937-3dfab34a6b99" />

<img width="817" height="693" alt="image" src="https://github.com/user-attachments/assets/1ab7adff-48c6-4359-994d-ee2086f3824b" />

