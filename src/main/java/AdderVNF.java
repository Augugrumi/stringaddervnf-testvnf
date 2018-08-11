import vfn.AbsBaseVNF;
import vfn.testvnfs.AddStringVNF;

public class AdderVNF extends AbsBaseVNF {

    private String toAdd;

    public AdderVNF(String toAdd, int port) {
        super(port);
        this.toAdd = toAdd;
    }

    public String functionality(String message) {
        return message.replace("\r\n\r\n", "\r\n").concat(toAdd);
    }

    public static void main(String[] args) {
        System.out.println("string to add: " + args[0]);
        System.out.println("port:          " + args[1]);
        new AddStringVNF(args[0], Integer.parseInt(args[1])).execute();
    }
}


