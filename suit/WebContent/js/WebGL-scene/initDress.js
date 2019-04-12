
function initDress( modelName, modelPath ) {

    //要加载的模型为obj,mtl
    var mtlName = modelName + '.mtl';
    var objName = modelName + '.obj';

    //加载模型所需要的材质
    THREE.Loader.Handlers.add( /\.tga$/i, new THREE.TGALoader() );
    THREE.Loader.Handlers.add( /\.dds$/i, new THREE.DDSLoader() );

    new THREE.MTLLoader()
        .setPath( modelPath )
        .load( mtlName, function ( materials ) {

            materials.preload();

            new THREE.OBJLoader()
                .setMaterials( materials )
                .setPath( modelPath )
                .load( objName, function ( object ) {

                    //设置模型的name属性，便于查找
                    object.name = modelName;

                    //设置加载模型比例
                  /*  object.scale.x = 1.8;
                    object.scale.z = 1.8;
                    object.scale.y = 1.8;*/

                    //设置加载模型位置
                    object.position.x = 40;

                    //使所有子对象都能够接受阴影
                    for ( var i in object.children ) {
                        if( object.children.hasOwnProperty(i) ) {
                            object.children[i].castShadow = true;
                            object.children[i].receiveShadow = true;
                        }
                    }
                    scene.add( object );
                }, onProgress, onError );

        } );
}

var onProgress = function ( xhr ) {

    if ( xhr.lengthComputable ) {

        var percentComplete = xhr.loaded / xhr.total * 100;
        console.log( Math.round( percentComplete, 2 ) + '% downloaded' );

    }

};

var onError = function () { };