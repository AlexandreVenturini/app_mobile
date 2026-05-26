from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    UsuarioViewSet,
    CategoriaViewSet,
    ProdutoViewSet,
    CarrinhoViewSet,
    ItemCarrinhoViewSet,
    PagamentoViewSet,
    MontagemViewSet,
    ItemMontagemViewSet
)

router = DefaultRouter()

router.register(r'usuarios', UsuarioViewSet)
router.register(r'categorias', CategoriaViewSet)
router.register(r'produtos', ProdutoViewSet)
router.register(r'carrinhos', CarrinhoViewSet)
router.register(r'itens-carrinho', ItemCarrinhoViewSet)
router.register(r'pagamentos', PagamentoViewSet)
router.register(r'montagens', MontagemViewSet)
router.register(r'itens-montagem', ItemMontagemViewSet)

urlpatterns = [
    path('', include(router.urls)),
]