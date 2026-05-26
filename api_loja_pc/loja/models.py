from django.db import models

class Usuario(models.Model):
    idUsuario = models.AutoField(primary_key=True)
    nome = models.CharField(max_length=100)
    email = models.EmailField(unique=True)
    cpf = models.CharField(max_length=14, unique=True)
    senha = models.CharField(max_length=255)
    endereco = models.CharField(max_length=150)

    class Meta:
        db_table = 'Usuario'

    def __str__(self):
        return self.nome


class Categoria(models.Model):
    idCategoria = models.AutoField(primary_key=True)
    nome = models.CharField(max_length=100)

    class Meta:
        db_table = 'Categoria'

    def __str__(self):
        return self.nome


class Produto(models.Model):
    idProduto = models.AutoField(primary_key=True)
    nome = models.CharField(max_length=100)
    descricao = models.CharField(max_length=255, blank=True, null=True)
    preco = models.DecimalField(max_digits=10, decimal_places=2)
    estoque = models.IntegerField(default=0)
    categoria = models.ForeignKey(Categoria,on_delete=models.CASCADE,db_column='idCategoria')

    class Meta:
        db_table = 'Produto'

    def __str__(self):
        return self.nome


class Carrinho(models.Model):
    idCarrinho = models.AutoField(primary_key=True)
    usuario = models.ForeignKey(Usuario,on_delete=models.CASCADE,db_column='idUsuario')
    valor = models.DecimalField(max_digits=10, decimal_places=2, default=0)
    status = models.CharField(max_length=30, default='Aberto')

    class Meta:
        db_table = 'Carrinho'


class ItemCarrinho(models.Model):
    idItemCarrinho = models.AutoField(primary_key=True)
    carrinho = models.ForeignKey(Carrinho,on_delete=models.CASCADE,db_column='idCarrinho')
    produto = models.ForeignKey(Produto,on_delete=models.CASCADE,db_column='idProduto')
    quantidade = models.IntegerField()
    precoUnitario = models.DecimalField(max_digits=10, decimal_places=2)

    class Meta:
        db_table = 'ItemCarrinho'

class Pagamento(models.Model):
    idPagamento = models.AutoField(primary_key=True)
    carrinho = models.ForeignKey(Carrinho, on_delete=models.CASCADE,db_column='idCarrinho')
    tipo = models.CharField(max_length=45)
    status = models.CharField(max_length=30, default='Pendente')
    dataPagamento = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'Pagamento'

class Montagem(models.Model):
    idMontagem = models.AutoField(primary_key=True)
    usuario = models.ForeignKey(Usuario, on_delete=models.CASCADE,db_column='idUsuario')
    nome = models.CharField(max_length=100)
    data = models.DateField()
    valorTotal = models.DecimalField(max_digits=10, decimal_places=2, default=0)

    class Meta:
        db_table = 'Montagem'

class ItemMontagem(models.Model):
    idItemMontagem = models.AutoField(primary_key=True)
    montagem = models.ForeignKey(Montagem, on_delete=models.CASCADE,db_column='idMontagem')
    produto = models.ForeignKey(Produto, on_delete=models.CASCADE,db_column='idProduto')
    quantidade = models.IntegerField()

    class Meta:
        db_table = 'ItemMontagem'