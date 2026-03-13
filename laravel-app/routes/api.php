<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Log;

Route::get('/', static fn() => response()->json(['message' => 'Hello from Laravel!']));

Route::get('/logs', static function () {
    Log::debug('This is an DEBUG log message.');
    Log::info('This is an INFO log message.');
    Log::warning('This is a WARNING log message.');
    Log::error('This is an ERROR log message.');
    Log::critical('This is an CRITICAL log message.');

    return response()->json(['message' => 'Log created successfully.']);
});

Route::post('/logs-with-context', static function (Request $request) {
    $param1 = $request->input('param_1', 'default_value_1');
    $param2 = $request->input('param_2', 'default_value_2');

    $context = [
        'param_1' => $param1,
        'param_2' => $param2,
    ];

    Log::info('Log with context', $context);

    return response()->json(['message' => 'Log with context created successfully.']);
});


Route::get('/logs-with-exception', static function () {
    try {
        throw new \RuntimeException('This is a test exception for logging.');
    } catch (\Throwable $th) {
        $context = [
            'error' => $th->getMessage(),
            'trace' => $th->getTraceAsString(),
        ];

        Log::error('An exception occurred', $context);
    }

    return response()->json(['message' => 'Exception log created successfully.']);
});
