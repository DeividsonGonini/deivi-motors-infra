exports.handler = async (event) => {
    if (event.httpMethod === "POST") {
        return {
            statusCode: 201,
            body: JSON.stringify({ message: "POST criado com sucesso!" }),
        };
    }

    return {
        statusCode: 200,
        body: JSON.stringify({ message: "GET funcionando!" }),
    };
};