<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class AuthController extends Controller
{
    //
    public function login(Request $request)
    {
        $request->validate([
            'email'=> 'required|email',
            "password"=>'required|min:8',
        ]
            
        );

        //Check credenciales
        $user = User::where('email',$request->email)->first();

        if(!$user || !Hash::check($request->password,$user->password)){
            return response()->json(['message'=>'Credenciales invalidas'],401);
        }

        $token = $user->createToken('inventario-lubricentro')->plainTextToken;

        return response()->json(['token'=>$token]);
    }

    public function logout(Request $request){
        $request->user()->tokens->each(function ($token){
            $token->delete();
        });

        return response->json(['message'=>"Sesión cerrada correctamente"]);

    }
}
