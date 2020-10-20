import 'package:create_shop/models/product.dart';
import 'package:create_shop/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductFormScreen extends StatefulWidget {
  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {

  //global key do formulario
  final _form = GlobalKey<FormState>();
  final _formData = Map<String,Object>();

  /*Gerenciador do foco do teclado para ir para segundo campo ao pressionar
  * "enter" no teclado*/
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  /*Perda de foco*/
  final _imageUrlFocusNode=FocusNode();
  final _imageUrlController = TextEditingController(text: "imageUrl");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imageUrlFocusNode.addListener(
        _updateUrl
    );
  }

  void _updateUrl(){
    /*validando o campo de imagem:
    * depois de fazer a entrada de dados para o campo imagem, o texto da url
    * é validado no metodo isValidImageUrl, passando o que o usário digitou
    * como entrada do parametro. Se o retorno for true, significa que está validado
    * e nesse caso, é dado um setState para fazer o update da imagem na perda de foco
    * do teclado.*/
    if(isValidImageUrl(_imageUrlController.text)){
      setState(() {
      });
    }
  }
  /*só vai ser chamado o setState, se a URL que estiver dentro do campo da imagem
  * estiver válida*/
  bool  isValidImageUrl(String url){
    //Validação da url
    bool startWithHttp = url.toLowerCase().startsWith('http://');
    bool startWithHttps = url.toLowerCase().startsWith('https://');
    bool endWithPng = url.toLowerCase().endsWith(".png");
    bool endWithJpg = url.toLowerCase().endsWith(".jpg");
    bool endWithJpeg = url.toLowerCase().endsWith(".jpeg");
    return (startWithHttp || startWithHttps) && (endWithPng || endWithJpg || endWithJpeg);
    //retornando true a expressão significa que passou nas validações
  }
  
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateUrl);
    _imageUrlFocusNode.dispose();
  }

  void _saveForm(){
    /*antes de salvar, chamar os metodos do parametro validator
    * se o formulario for valido retorna verdadeiro*/
    var isValid =_form.currentState.validate();

    //validação do formulário
    /*caso formulário não for válido, não irá fazer nada, e os processos abaixo
    * do if, como salvar e criar um novo produto não serão feitos, pois irá
    * sair da função*/
    if(!isValid){
      return;
    }

    /*metodo save vai chamar o onSave de cada um dos campos do formulário*/
    _form.currentState.save();
    /*criando um novo produto a partir dos parametros recebidos de cada
    * método onSaved de cada TextFormField que foi chamado pelo
    * _form.current.save()*/

    final newProduct = Product(
      id: _formData["id"],
      title: _formData["title"],
      price: _formData["price"],
      description: _formData["description"],
      imageUrl: _formData["imageUrl"]
    );

    //salvando o novo produto no provider
    final products = Provider.of<ProductProvider>(context,listen: false);
    //teste no provider
    if(_formData["id"]==null){
      products.addProduct(newProduct);
    }else{
      //update
      products.updateProduct(newProduct);
    }
    //saindo da tela após salvar o novo produto
    Navigator.of(context).pop();
  }
  //método associado ao state, smp que é renderizado o state permanace e o state é mudado
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    /*só vamos preencher o _formaData com paramentros vindo de outra tela, caso
    * ele ainda não tenha recebido nada, pq vai indicar que a primeira vez que ele entra na tela*/
    if(_formData.isEmpty){
      final product = ModalRoute.of(context).settings.arguments as Product;
      if(product!=null){
        _formData["id"] = product.id;
        _formData["title"] = product.title;
        _formData["description"] = product.description;
        _formData["price"] = product.price;
        _formData["imageUrl"] = product.imageUrl;

        //inicialização do valor inicial da imagem
        _imageUrlController.text = _formData["imageUrl"];

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulário produto"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: (){
              _saveForm();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _formData["title"],
                validator: (value){
                  //função retorna uma string
                  //retornando null, significa que não tem nenhum erro de validação
                  bool isEmpty = value.trim().isEmpty;
                  bool isInvalid = value.trim().length < 3;
                  if(isEmpty || isInvalid){
                    //trim() tira espaços em branco
                    /*Mensagem do return nesse caso será colocada como a
                  * mensagem de erro do campo*/
                    return "Informe um titulo válido";
                    return "Informe uma descrição válida";
                  }else{
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: "Título",
                  //OBs: também é possivel colocar um texto de erro através do decoration
                  //errorText: "Teste Erro"
                ),
                /*botão do teclado "enter" vai passar para o TextField abaixo*/
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_){
                  /*Método chamado sempre que é pressionado enter
                  * a variavel está declarada como o focus node do textField
                  * abaixo com isso, quando a campo for subimetido clicando
                  * em enter, vai chamar o FoscusScope que irá requisitar o foco
                  * para a virável passada. Que por estar referenciada em outro
                  * campo, dará o foco para aquele campo*/
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (value){
                  _formData['title'] = value;
                },
              ),



              TextFormField(
                initialValue: _formData["price"].toString(),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                focusNode: _priceFocusNode,
                decoration: InputDecoration(
                    labelText: "Preço"
                ),
                /*botão do teclado "enter" vai passar para o TextField abaixo*/
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_){
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (value){
                  _formData['price'] = double.parse(value);
                },
                validator: (value){
                  /*preço com espaço
                  * preço nulo ou menor igual 0*/
                  bool isEmpty = value.trim().isEmpty;
                  var newPrice = double.tryParse(value);
                  bool isInvalid = newPrice==null || newPrice <=0;
                  if(isEmpty || isInvalid){
                    return "Informe um preço válido";
                  }else{
                    return null;
                  }
                },
              ),



              TextFormField(
                initialValue: _formData["description"],
                maxLines: 3,
                focusNode: _priceFocusNode,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    labelText: "Descrição"
                ),
                validator: (value){
                  bool isEmpty = value.trim().isEmpty;
                  bool isInvalid = value.trim().length < 10;
                  if(isEmpty || isInvalid){
                    return "Informe uma descrição válida";
                  }else{
                    return null;
                  }
                },
                onSaved: (value){
                  _formData["description"] = value;
                },

              ),





              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      initialValue: _formData["imageUrl"],
                        validator: (value) {
                          bool isEmpty = value.trim().isEmpty;
                          bool isInvalid = !isValidImageUrl(value);

                          if (isEmpty || isInvalid) {
                            return 'Informe uma URL válida!';
                          }

                          return null;
                        },
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      decoration: InputDecoration(
                        labelText: "URL da imagem"
                      ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_){
                        _saveForm();
                      },
                        onSaved: (value){
                          _formData['imageUrl'] = value;
                        }
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 8,left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1
                      )
                    ),
                      alignment: Alignment.center,
                    child: _imageUrlController.text.isEmpty ?
                        Text("Informe a URL")
                        : FittedBox(
                      child: Image.network(
                        _imageUrlController.text,
                        fit: BoxFit.cover,
                      ),
                    )
                  )
                ],
              )



            ],
          ),
        ),
      ),
    );
  }
}
