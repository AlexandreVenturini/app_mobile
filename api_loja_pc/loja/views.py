from rest_framework import viewsets
from .models import Usuario, Categoria, Produto, Carrinho, ItemCarrinho, Pagamento, Montagem, ItemMontagem
from .serializers import (
    UsuarioSerializer,
    CategoriaSerializer,
    ProdutoSerializer,
    CarrinhoSerializer,
    ItemCarrinhoSerializer,
    PagamentoSerializer,
    MontagemSerializer,
    ItemMontagemSerializer
)


class UsuarioViewSet(viewsets.ModelViewSet):
    queryset = Usuario.objects.all()
    serializer_class = UsuarioSerializer


class CategoriaViewSet(viewsets.ModelViewSet):
    queryset = Categoria.objects.all()
    serializer_class = CategoriaSerializer


class ProdutoViewSet(viewsets.ModelViewSet):
    queryset = Produto.objects.all()
    serializer_class = ProdutoSerializer


class CarrinhoViewSet(viewsets.ModelViewSet):
    queryset = Carrinho.objects.all()
    serializer_class = CarrinhoSerializer


class ItemCarrinhoViewSet(viewsets.ModelViewSet):
    queryset = ItemCarrinho.objects.all()
    serializer_class = ItemCarrinhoSerializer


class PagamentoViewSet(viewsets.ModelViewSet):
    queryset = Pagamento.objects.all()
    serializer_class = PagamentoSerializer


class MontagemViewSet(viewsets.ModelViewSet):
    queryset = Montagem.objects.all()
    serializer_class = MontagemSerializer


class ItemMontagemViewSet(viewsets.ModelViewSet):
    queryset = ItemMontagem.objects.all()
    serializer_class = ItemMontagemSerializer