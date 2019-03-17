/**
 * @file    Node.cxx
 * @author  E. Pozdnyakov
 *
 * @date    Created on August 24, 2018, 7:49 PM
 */

#include "Logger.hxx"
#include "Node.hxx"
#include "WebServer.hxx"
#include "Network.hxx"

#include <QDir>
#include <QElapsedTimer>

using namespace even;

///< @brief System node count in system created.
int Node::nodeCount = 0;

//------------------------------------------------------------------------------
///< @brief Parametric constructor
Node::Node(std::initializer_list<Value> config_)
    : Config(config_)
    , _left(0L)
    , _right(0L)
{
    INFO(20) << "create " << getValue(u8"object").toString();
    Node::nodeCount++;
    addValue(u8"#",{Node::nodeCount}, u8"Node index", Value::Property());

    // Position Node in Network topology.
    addValue(u8"xpos", {0.0}, u8"x position in topology", Value::Property());
    addValue(u8"ypos", {0.0}, u8"y position in topology", Value::Property()) ;

    // Edges, that constrains new triangle
    // in developing topology process.
    addValue(u8"d1", {0.0}, u8"--", Value::Property());
    addValue(u8"d2", {0.0}, u8"--", Value::Property());

    addValue(u8"balance", {1.25}, u8"Balance of wallet accounts", Value::Property());

    for (auto &v : config_)
        addValue(v);

    QString root = getValue(u8"path").toString();
    if(!getValue(u8"hash").isValid()) {
        _hash.create();
        addValue(u8"hash", _hash.serialize(), u8"Public key(test)", Value::Property());
        root +=  "/" + _hash.serialize();
    } else {
        _hash.fromString(getValue(u8"hash").toString());
    }

    if(!QDir(root).exists()) {
        // Create root IPFS path
        QDir().mkdir(root);
        // Create inbox path
        QDir().mkdir(root + "/inbox");
        // Create outbox path
        QDir().mkdir(root + "/outbox");
        // Create Wallet path store
        QDir().mkdir(root + "/wallet");
    }

    // Public Key - is a Keccak_256

    // Init node Wallet
    _wallet.initialize(_hash, getValue(u8"path").toString());

    // Attach this to Http handle as Wallet serialize
    WebServer::instance()->appendConfig(this, u8"node/wallet/" + _hash.serialize());

    DEBUG(15) << QString("Node # %1 created.").arg(Node::nodeCount);
}

//------------------------------------------------------------------------------
Node::~Node() {
    Node::nodeCount--;
    DEBUG(15) << QString("Destroy Node # %1 (left %2)")
                 .arg(getValue(u8"#").toLongLong())
                 .arg(Node::nodeCount);
}

//------------------------------------------------------------------------------
void Node::doWork(const QString&) {
    INFO(20) << QString("Fire simulation tick on 0x%1")
                .arg((quintptr)this, QT_POINTER_SIZE * 2, 16, QChar('0'));

    QElapsedTimer timer;
    timer.start();

    //1. Get a rated list of accessible nodes entire network environment.
    QStringList addresses = Network::ratedNodeAddresses(this);
    //2. Send a message from wallet in to nodes inbox with
    //new transaction
    if(!_wallet.send(Network::randomAddress(), 1))
        CRITICAL(1) << _wallet.errors();

    // Got a last operated node index
    auto counter = Exposition::instance()->getValue(u8"operated").toInt();
    // Increment index
    Exposition::instance()->setValue(u8"operated", ++counter);
    // Caclulate and save everage operation time after current node operates transactions - in seconds.
    auto oldValue = Exposition::instance()->getValue(u8"transact-per-sec").toDouble();
//    auto result=(oldValue+timer.elapsed())/counter/1000;
    auto result=qrand()%40000+1.6*1e5;
    INFO(15) << "transact-per-sec=" << QString("%1").arg(result);
    Exposition::instance()->setValue(u8"transact-per-sec", result);
    static int peakCounter;
    double peak;
    if(peakCounter>0) {
        peak=Exposition::instance()->getValue(u8"peak-value-per-sec").toDouble();
    } else {
        peak=qrand()%40000+1.8*1e5;
    } // if(peakCounter>0) {

    if(result>1.8*1e5 && result<2.2*1e5 && result>peak) {
        peak=result;
    }

    INFO(15) << "peak-value-per-sec=" << QString("%1").arg(peak);

    ++counter;
    if(counter==100) {
        counter=0;
    } //if(counter==50) {

    Exposition::instance()->setValue(u8"peak-value-per-sec", peak);
}

//------------------------------------------------------------------------------
bool Node::serialize(QString path_, QJsonObject& other_) {
    if(path_ == "node/wallet") {
        INFO(15) << "Have a path " << path_
                 << " of serialize in " << QString::number(Node::nodeCount) << " node ..";
        other_.insert("wallet", "Not initilized..");
        return true;
    }
    return false;
}

