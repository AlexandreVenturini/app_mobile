from rest_framework import serializers
from .models import Usuario, Categoria, Produto, Carrinho, ItemCarrinho, Pagamento, Montagem, ItemMontagem


class UsuarioSerializer(serializers.ModelSerializer):
    class Meta:
        model = Usuario
        fields = '__all__'


class CategoriaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Categoria
        fields = '__all__'


class ProdutoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Produto
        fields = '__all__'


class CarrinhoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Carrinho
        fields = '__all__'


class ItemCarrinhoSerializer(serializers.ModelSerializer):
    class Meta:
        model = ItemCarrinho
        fields = '__all__'


class PagamentoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Pagamento
        fields = '__all__'


class MontagemSerializer(serializers.ModelSerializer):
    class Meta:
        model = Montagem
        fields = '__all__'


class ItemMontagemSerializer(serializers.ModelSerializer):
    class Meta:
        model = ItemMontagem
        fields = '__all__'