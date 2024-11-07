<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request; //Para manejar las solicitudes HTTP
use Illuminate\Support\Facades\Validator; //Para validar los datos de cada entrada

class UserController extends Controller
{
    //crear un nuevo usuario

    public function store(Request $request){
        //Se validan los datos que vienen en la solicitud, se definen reglas que deben cumplir los datos de la solicitud
        $validar = Validator::make($request->all(),[ 
            'nombre'=> 'required|string|max:100',
            'email'=> 'required|email|unique:usuarios,email',
            'password' => 'required|string|min:6',
            'id_rol' => 'required|integer',
        ]);

        // Si la validación falla se envía una respuesta con el error código de estado HTTP 422 (Unprocessable Entity)

        if($validar->fails()){
            return response()->json(['errors'=>$validar->errors()],422);
        }

        $user = User::create([
            'nombre'=>$request->nombre,
            'email'=>$request->email,
            'password'=>$request->password,
            'id_rol'=>$request->id_rol
        ]);

        return response()->json(['message'=> 'Usuario creado exitosamente','data'=>$user],201);
    }

    public function index(){
        return response()->json(User::all(),200);
    }
    public function show($id){
        $usuario =  User::find($id);
        if(!$usuario){
            return response()->json(['error'=>'Usuario no encontrado'],404);
        }
        return response()->json($usuario,200);
    }

    public function update(Request $request, $id){

        $usuario = User::find($id);

        if(!$usuario){
            return response()->json(['error'=>'Usuario no encontrado'],404);
        }

         // Imprime en el log de Laravel el valor de `$request`
        \Log::info('Datos recibidos en el request:', $request->all());

        $request->validate([ 
            'nombre'=> 'string|max:100',
            'email'=> 'email|unique:usuarios,email',
            'password' =>'string|min:6',
            'id_rol' => 'integer',
        ]);

        if($request->has('nombre')){
            $usuario->nombre = $request->nombre;      
        }

        if($request->has('email')){
            $usuario->email = $request->email;
        }

        if($request->has('password')){
            $usuario->password = $request->password;
        }

        if($request->has('id_rol')){
            $usuario->id_rol = $request->id_rol;
        }

        $usuario->save();

        return response()->json(['Mensaje'=>'Usuario actualizado correctamente', 'usuario'],200);
    }

    public function delete($id){
        $usuario = User::find($id);

        if(!$usuario){
            return response()->json(['error'=>'Usuario no encontrrado'],404);
        }
        $usuario->delete();
        return response()->json(['message'=>'Usuario eliminado'],200);
    }
}
