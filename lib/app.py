from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/run-python', methods=['POST'])
def run_python():
    data = request.json
    # Example Python code execution
    result = {"result": "Python code executed successfully!"}
    return jsonify(result)

if __name__ == '__main__':
    app.run(debug=True)
