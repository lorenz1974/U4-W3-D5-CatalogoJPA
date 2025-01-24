package u4w3.dao;

import u4w3.entities.Libro;
import jakarta.persistence.EntityManager;
import u4w3.exception.ErroreGenericoException;

import java.util.List;

public class LibroDAO {

    private final EntityManager em;

    public LibroDAO(EntityManager em) {
        this.em = em;
    }

    public List<Libro> findByAutore(String autore) throws ErroreGenericoException {
        try {
            return em.createQuery("SELECT l FROM Libro l WHERE l.autore = :autore", Libro.class)
                    .setParameter("autore", autore)
                    .getResultList();
        } catch (Exception e) {
            throw new ErroreGenericoException("Errore durante la ricerca dei libri per autore: " + e.getMessage());
        }
    }

    public List<Libro> findByGenere(String genere) throws ErroreGenericoException {
        try {
            return em.createQuery("SELECT l FROM Libro l WHERE l.genere = :genere", Libro.class)
                    .setParameter("genere", genere)
                    .getResultList();
        } catch (Exception e) {
            throw new ErroreGenericoException("Errore durante la ricerca dei libri per genere: " + e.getMessage());
        }
    }
}